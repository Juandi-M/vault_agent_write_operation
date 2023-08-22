pid_file = "/vault-agent.pidfile"

exit_after_auth = true

auto_auth {

  method {
    # Activate the token_file method
    type = "token_file"
    config = {
      token_file_path = "/etc/vault.d/.vault-token"
    }

    // method {
    //   # Fallback method: approle
    //   type = "approle"
    //   config = {
    //     role_id_file_path   = "/path/to/role-id"
    //     secret_id_file_path = "/path/to/secret-id"
    //     remove_after_reading = {
    //       role_id   = true
    //       secret_id = true
    //     }
    //   }
    // }
  }

  sink {
    type = "file"
    config = {
      path             = "/etc/vault.d/.vault-token"
      remove_after_use = true
    }
  }
}

api_proxy {
  use_auto_auth_token = true
}

# Templating files & paths

template {
  source               = "/etc/vault.d/appconfigs.ctmpl"
  destination          = "/home/vault/appconfigs.json"
  error_on_missing_key = true
}

listener "tcp" {
  address     = "127.0.0.1:8100"
  tls_disable = true
}