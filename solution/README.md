## First Stage
Cloned the Repository with "git clone https://github.com/atvenu/devOpsAssignment" using gitbash on my VScode IDE having already installed Docker Desktop version '4.27.0' on my Windows Laptop
Created a Private repository on my Github account, created and navigated into the solutions directory with the command mkdir and cd notes/fixes/files 

Pulled the webserver image and prometheus image into my work environment using these codes below;

docker pull atvenu/assignment-webserver
docker pull prom/prometheus:v2.45.2

## Part 1
After I pulled the docker image into my environment, I used the command "docker image ls" to list the images

Ran the container image atvenu/assignment-webserver:latest in the background using this command "docker run --name assignment-webserver -d -P f6c6c5905cbe ", I checked for running containers with docker ps but found non running I went further to check for containers in all states using "docker ps -a", I found a container in a failed state with status "exited". I went further to do docker inspect, the error was indicated by the "ExitCode": 1 in the "State" section of the output.

Used "docker logs -CID 591f337fa995" to check reason why the container wasn't running and got error 2024/02/04 22:36:05 Error reading CSV file:open /app/data.csv: no such file or directory

The error means that the CSV file cannot be found at the /app location because it does not exist in the container's filesystem. The way to solve this is by mounting the volume on /app/data.csv

Created a bash script to Answer numbers 2 and 3 and made it executable with "chmod +x csv.sh", A range is not given for the choice of random numbers explicitly, However, since the example given is four digits, I have chosen the range from 1 to 2999. Executed the script using the "sh csv.sh" which created the data.csv file in the solution directory.

Ran this command to mount the volume "docker run -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/data.csv:/app/data.csv f6c6c5905cbe", this made it listen on port 8080.

Ran this command and it finally worked "docker run --name assignment-webserver -d -P -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/data.csv:/app/data.csv f6c6c5905cbe" the -P flag exposed the application on windows range of ports.

I stopped the container using "docker stop/ rm container ID"

I then portmapped the container to the host port using the -p flag "-p 9090:8080" which gave access to the application on the host.

I stopped the container using "docker rm container ID"

Using this command "docker run --name assignment-webserver -d -p 9090:8080  -e BORDER_COLOR=blue -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/part_1/data.csv:/app/data.csv f6c6c5905cbe", I was able to add the blue border to the application and able to view the result.

## Part 2
I deleted the previous container using the command " docker stop and rm ContainerID"
Created a Part 2 directory and a new data.csv file
Created a docker-compose yaml file with versions '3.8' and parsed the host volume path as "./" different from the previous
I started the container with the command using "docker compose up -d" which then ran the application sucessfully 

## Part 3
I deleted the previous container using the command " docker rm ContainerID"
Created a Part 3 directory aligning with the task and Generated a new data.csv file using the csv.sh created in part 1
I updated to the previously established docker compose file the prometheus container data and made it depend on the "assignment-webserver" running first
Created a prometheus.yml file that defined the scraping configuration for Prometheus.
When starting Prometheus, an error occurred indicating it couldn't find the prometheus.yaml configuration file. Checked the error by running the command "docker-compose logs prometheus" which showed the below;

"prometheus  | ts=2024-02-06T16:06:37.726Z caller=main.go:482 level=error msg="Error loading config (--config.file=/etc/prometheus/prometheus.yaml)" file=/etc/prometheus/prometheus.yaml err="open /etc/prometheus/prometheus.yaml: no such file or directory"
prometheus  | ts=2024-02-06T16:11:12.896Z caller=main.go:482 level=error msg="Error loading config (--config.file=/etc/prometheus/prometheus.yaml)" file=/etc/prometheus/prometheus.yaml err="open /etc/prometheus/prometheus.yaml: no such file or directory"

Trobleshooted by re-writing the volume "volumes: - ./prometheus.yml:/etc/prometheus/prometheus.yml"

I stopped and removed the previous containers, and ran "docker compose up" which then ran successfully.

Attached to each parts are the screenshots of the results.

This was an interesting project. Thank you.