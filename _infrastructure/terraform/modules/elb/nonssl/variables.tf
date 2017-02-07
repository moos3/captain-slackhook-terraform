variable "options" {
  type = "map"

  default = {
    tag                = "unknown"
    app_name           = "unknown"
    subnets            = "unknown"
    elb_security_group = "unknown"
    listen_port_http   = "80"
    elb_hc_uri         = "/"
    lb_port            = "80"
    lb_protocol        = "http"
    hc_protocol        = "http"
  }
}
