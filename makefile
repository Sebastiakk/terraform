# Variables de configuración
RESOURCE_GROUP="tfstate-rg"
STORAGE_ACCOUNT="kiustate"
CONTAINER_NAME="tfstate"
LOCATION="eastus"
INFRA_DIR_DEV="infra/envs/dev"
APP_DIR="app/deploy"
SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"

# Validar que las herramientas están instaladas antes de ejecutar cualquier otro comando
check-tools:
	@command -v terraform >/dev/null 2>&1 || { echo "❌ Terraform no está instalado. Instálalo antes de continuar."; exit 1; }
	@command -v az >/dev/null 2>&1 || { echo "❌ Azure CLI no está instalado. Instálalo antes de continuar."; exit 1; }
	@echo "✅ Todas las herramientas necesarias están instaladas."

# Crear Resource Group si no existe
create-rg: check-tools
	@if ! az group show --name $(RESOURCE_GROUP) >/dev/null 2>&1; then \
		echo "⏳ Creando Resource Group $(RESOURCE_GROUP)..."; \
		az group create --name $(RESOURCE_GROUP) --location $(LOCATION); \
	else \
		echo "✅ Resource Group $(RESOURCE_GROUP) ya existe."; \
	fi

# Crear Storage Account si no existe
create-storage: check-tools create-rg
	@if ! az storage account show --name $(STORAGE_ACCOUNT) --resource-group $(RESOURCE_GROUP) >/dev/null 2>&1; then \
		echo "⏳ Creando Storage Account $(STORAGE_ACCOUNT)..."; \
		az storage account create --name $(STORAGE_ACCOUNT) --resource-group $(RESOURCE_GROUP) --location $(LOCATION) --sku Standard_LRS; \
	else \
		echo "✅ Storage Account $(STORAGE_ACCOUNT) ya existe."; \
	fi

# Crear contenedor en el Storage Account
create-container: check-tools create-storage
	@STORAGE_KEY=$$(az storage account keys list --resource-group $(RESOURCE_GROUP) --account-name $(STORAGE_ACCOUNT) --query "[0].value" -o tsv); \
	if ! az storage container show --name $(CONTAINER_NAME) --account-name $(STORAGE_ACCOUNT) >/dev/null 2>&1; then \
		echo "⏳ Creando contenedor $(CONTAINER_NAME)..."; \
		az storage container create --name $(CONTAINER_NAME) --account-name $(STORAGE_ACCOUNT) --account-key $$STORAGE_KEY; \
	else \
		echo "✅ Contenedor $(CONTAINER_NAME) ya existe."; \
	fi

# Inicializar Terraform Backend
initialize-state: check-tools create-container
	@echo "🎉 Backend de Terraform configurado correctamente."

terraform-init: check-tools initialize-state
	@echo "⏳ Inicializando Terraform en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform init -backend-config="subscription_id=$(SUBSCRIPTION_ID)" -var-file="terraform.tfvars"
	@echo "✅ Terraform inicializado correctamente en $(INFRA_DIR_DEV)/"


# Validar la sintaxis de los archivos de Terraform
terraform-validate: check-tools
	@echo "⏳ Validando la sintaxis de los archivos de Terraform en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform validate
	@echo "✅ Sintaxis de los archivos de Terraform validada correctamente en $(INFRA_DIR_DEV)/"


# Generar el plan de infraestructura
terraform-plan:  terraform-init
	@echo "⏳ Generando el plan de infraestructura en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform plan -var="subscription_id=$(SUBSCRIPTION_ID)" -var-file="terraform.tfvars"
	@echo "✅ Plan de infraestructura generado correctamente en $(INFRA_DIR_DEV)/"


# Aplicar el plan de infraestructura
terraform-apply: terraform-init
	@echo "⏳ Aplicando el plan de infraestructura en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform apply -auto-approve -var="subscription_id=$(SUBSCRIPTION_ID)" -var-file="terraform.tfvars"
	@echo "✅ Plan de infraestructura aplicado correctamente en $(INFRA_DIR_DEV)/"


# Destruir la infraestructura
terraform-destroy: terraform-init
	@echo "⏳ Destruyendo la infraestructura en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform destroy -auto-approve -var="subscription_id=$(SUBSCRIPTION_ID)" -var-file="terraform.tfvars"
	@echo "✅ Infraestructura destruida correctamente en $(INFRA_DIR_DEV)/"


terraform-output: terraform-init
	@echo "⏳ Obteniendo las salidas de Terraform en $(INFRA_DIR_DEV)/..."
	cd $(INFRA_DIR_DEV) && terraform output
	@echo "✅ Salidas de Terraform obtenidas correctamente en $(INFRA_DIR_DEV)/"
