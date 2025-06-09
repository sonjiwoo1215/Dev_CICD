data "aws_ecr_authorization_token" "ecr_token" {
}

resource "kubernetes_secret" "aws_ecr_cred" {
  metadata {
    name = "aws-ecr-cred"
    namespace = "prgms-notes"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${data.aws_ecr_authorization_token.ecr_token.proxy_endpoint}" = {
          "username" = data.aws_ecr_authorization_token.ecr_token.user_name
          "password" = data.aws_ecr_authorization_token.ecr_token.password
          "auth" = data.aws_ecr_authorization_token.ecr_token.authorization_token
        }
      }
    })
  }
}
