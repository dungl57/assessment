module "api" {
  source = "../../modules/api"

  lambda_authorizer_filename  = var.lambda_authorizer_filename
  region   = var.region
  weather_authorizer  = var.weather_authorizer
  weather_api = var.weather_api
  function_name   = var.function_name
  default_tags    = var.default_tags
}
