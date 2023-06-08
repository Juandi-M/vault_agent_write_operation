# Vault Agent

## What is Vault?
  - Vault Agent is a lightweight process that runs on a client machine and interacts with Vault to retrieve and manage secrets. It can be used to automate the retrieval of secrets from Vault and provide them to applications running on the same machine or in containers. Vault Agent can also help to reduce the amount of code required to interact with Vault by abstracting away the complexity of authentication, token management, and secret retrieval.
   
## Objectives
  - The purpose of this POC was to create a dockerized version of the Vault Agent that could connect to the existent Vault server and retrieve the secrets stored on it.

## Vault Agent with Docker Compose
  - When running multiple containers on a single machine using Docker Compose, it is often necessary to securely share secrets between containers. Vault Agent can be used to retrieve secrets from Vault and make them available to other containers on the same machine.

  - Here is an overview of the steps involved in using Vault Agent with Docker Compose:

    1. Define a service for Vault Agent in the docker-compose.yml file, specifying the Vault address and credentials.
    2. Define a shared volume in the docker-compose.yml file that is accessible by both the Vault Agent container and the application containers.
    3. Create a Vault policy that grants the necessary permissions for the Vault Agent to access the secrets required by the application.
    4. Create a Vault role that associates the Vault Agent with the appropriate policy and generates an authentication token.
    5. Configure Vault Agent using the vault-agent.hcl file to specify the path to the secrets in Vault, the destination for the secrets, and the method for authentication.
    6. Configure the application to read the secrets from the shared volume.

