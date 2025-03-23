variable "lambda_authorizer_filename" {
  description = "The filename of the Lambda authorizer zip file."
  type        = string
}

variable "region" {
    type = string
    default = "ap-southeast-1"
}

variable "weather_authorizer" {
    type = string
    default = "" 
}

variable "weather_api" {
    type = string
    default = ""
}

variable "function_name" {
    type = string
    default = ""
}
