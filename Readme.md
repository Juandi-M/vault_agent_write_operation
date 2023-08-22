# Express Website with Vault Agent Templating and Secret Injection

This project illustrates the capabilities of Vault Agent Templating and Secret Injection in managing sensitive configurations for a basic Node.js & Express website. The application integrates Docker for containerization and employs NGINX as a proxy.

## Table of Contents

- [Project Structure](#project-structure)
- [Application Overview](#application-overview)
- [Prerequisites](#prerequisites)
- [Running the Application](#running-the-application)
- [Development and Debugging](#development-and-debugging)
- [Vault Agent Templating and Secret Injection](#vault-agent-templating-and-secret-injection)
- [Contributing](#contributing)
- [License](#license)

## Project Structure
```ascii
vaultAgent-docker/
├── nginx/
│   ├── nginx_headers.conf
│   ├── web-app-proxy.conf
│   └── vhost.d/
│       └── default_location
├── Vault-config/
│   ├── appconfigs.ctmpl
│   ├── role-id
│   ├── secret-id
│   └── vault-agent.hcl
├── WebRender/
│   ├── routes/
│   │   └── routes.js
│   ├── utils/
│   │   ├── configLoader.js
│   │   └── htmlRenderer.js
│   ├── webTemplates/
│   |   └── template.html
│   ├── App.js
│   ├── appconfigs.js
│   ├── package.json
├── .dockerignore
├── docker-compose.yml
├── Dockerfile
└── README.md
```

## Application Overview

The Express website dynamically serves content, referencing the `WebTemplates` folder. Sensitivities such as database credentials or API keys required by the website are retrieved from HashiCorp Vault. Vault Agent manages the templating and secret injection, ensuring a secure, reduced-risk data handling process.

## Prerequisites

- **Docker**: Obtainable from Docker's [official website](https://www.docker.com/).
- **Node.js**: Advantageous for local development. Available at Node.js's [official website](https://nodejs.org/).

## Running the Application

To run the application, follow these steps:

CODE:

Clone the repository:
```bash
git clone <your-repository-url>
cd <your-repository-directory>
docker-compose up --build
 ```

Visit the website at http://localhost.

Accessing Application Logs
To access logs from the web-app-render container:

CODE:

```bash
Copy code
docker logs -f web-app-render
```

Development and Debugging
Ensure files and directories are correctly positioned.

Docker must be able to access and mount necessary directories/files.

Validate the accuracy of application configurations (appconfigs.json).

CODE:

```bash
Copy code
docker exec -it web-app-render /bin/sh
Move to /app within the container for file inspections or script executions.
```

## Vault Agent Templating and Secret Injection

**Vault Agent**, developed by HashiCorp, is a robust tool that provides automatic Vault authentication and token renewal capabilities. A key feature is its proficiency in rendering configuration files and injecting secrets.

### How Does it Work?

1. **Configuration with HCL**: Vault Agent's behavior is determined by its HCL configuration. This essential file details authentication methods, template rendering, secret retrieval, and output destinations.
2. **Authentication**: Vault Agent first authenticates with Vault, with the HCL file specifying the `token_file` authentication method.
3. **Fetching Secrets**: After authentication, secrets are sourced from Vault based on the provided template file paths.
4. **Templating**: Using Go's `text/template` syntax—enhanced with Vault-specific functions—the `.ctmpl` files process secrets. For this project, `appconfigs.ctmpl` manages secret retrieval from `devops/kv/vault-templating-poc`, formatting them into structured JSON.
5. **Output**: The completed file is saved at its specified location after the templating process.
6. **Docker Integration**: Docker Compose oversees the Vault Agent from within a separate container. Volumes ensure the web application has proper access and placement for the templated outputs.

### Key Components

- **auto_auth**: Specifies Vault Agent's authentication methods.
- **api_proxy**: Optimizes the auto-auth token's use for the agent's API proxy.
- **template**: Connects templates to their end destinations, describing error handling and file paths.

### Additional Considerations

- **Error Handling**: The HCL configuration proactively captures missing key errors, ensuring uninterrupted application operations.
- **Hardcoded Values**: Not all values in `appconfigs.ctmpl` are dynamic. Some hardcoded values might exist. Remember, not every templated value needs to come from Vault—templates can include constants too.

## Contributing

For those looking to contribute:

1. **Fork the Repository**: Clone the project to ensure you're not modifying the main project directly.
2. **Make Changes**: Always work on a new branch to keep your changes separate.
3. **Push to Your Fork**: Continually back up your fork with your changes.
4. **Submit a Pull Request**: Once satisfied, open a pull request to merge your changes into the main project.

## License

This project is licensed under the MIT License. Refer to the LICENSE file for more details.

*Note: Adjust the content as necessary to better reflect the specifics of your project or to add more detailed information as needed.*