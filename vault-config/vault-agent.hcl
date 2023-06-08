pid_file = "/vault-agent.pidfile"

vault {
  address = "http://vaultaddress:8200"
}
exit_after_auth = true

auto_auth {
  method {
    type = "approle"
    config = {
      role_id_file_path = "/etc/vault.d/auth-staging-role-id"
      secret_id_file_path = "/etc/vault.d/auth-staging-secret-id"
      remove_secret_id_file_after_reading = false
    }
  }

  sink  {
    type = "file"
    config = {
      path = "/etc/vault.d/token"
    }
  }
}

cache{
 use_auto_auth_token = false
}

#api-env
template {
  source      = "/etc/vault.d/api-env.ctmpl"
  destination = "/home/vault/api-env"
  error_on_missing_key = true
}

#web-env
# Second template example. There's no env files for AUTH web
#template {
#  source      = "/etc/vault.d/web-env.ctmpl"
#  destination = "/home/vault/web-env"
#  error_on_missing_key = true
#}

listener "tcp" {
  address     = "127.0.0.1:8100"
  tls_disable = true
}
