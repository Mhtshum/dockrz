# dockrz

### Prerequisites
- [Install & start Docker Desktop](https://docs.docker.com/engine/install/)


#Different development stragedies 
using different branches for each scenario

## Local react development without node and react on local 
- In this we can create react app using vite@6.4.3 and locally having following folder structure
my-react-app/
├── docker-compose.yml
├── Dockerfile
└── ca/
    ├── package.json
    ├── public/
    └── src/

src folder is containing the files to be test for react 

branchname:nodeandreactincontainer