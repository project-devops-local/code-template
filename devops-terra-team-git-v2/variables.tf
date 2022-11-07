variable "teams" {
  type = map(object({
    description = string
    members     = set(string)
    permission  = string
  }))
  description = "Definicion de todos los equipos y miembros"

}


