

region       = "ap-southeast-1"
environment  = "test"
project_name = "nginx-test"

nginx_config = {
  nginx_config_path = "./nginx/test-nginx.conf"
  ssl_cert_path     = "../.secrets/certs/amazonaws.com"
  key_file          = "../.secrets/nginx"
}
