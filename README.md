# dockrz

### Prerequisites
- [Install & start Docker Desktop](https://docs.docker.com/engine/install/)


#Different development stragedies 
using different branches for each scenario

## Local react development without node and react on local and files updated in container asap by file watcher.
- In this we can create react app using vite@6.4.3 and locally having following folder structure

    ```bash	
    ├── my-react-app/
    │   ├── ca/	
    │   ├── public/	
    │   ├── src/	
    │   ├── Dockerfile
    │   ├── docker-compose.yml
    │   ├── docker-entrypoint.sh
    ```
		
src folder is containing the files to be test for react 
docker-entrypoint.sh will setup a loop to check any changes in files in /app/temp-src/src (mounted folder) and if fine any then update the src folder inside react application of container

> branchname : reactbycontainer_nodealpine_files_sync 
