output "remote_state_outputs" {
  description = "Salida de estado remoto."
  value       = data.terraform_remote_state.remote_state.outputs
}
