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

Created a bash script to Answer numbers 2 and 3 and made it executable with "chmod +x csv.sh", A range is not given for the choice of random numbers explicitly, However, since the example given is four digits, I have chosen the range from 1 to 3000. Executed the script using the "sh csv.sh" which created the data.csv file in the solution directory.

Ran this command to mount the volume "docker run -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/data.csv:/app/data.csv f6c6c5905cbe", this made it listen on port 8080.

Ran this command and it finally worked "docker run --name assignment-webserver -d -P -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/data.csv:/app/data.csv f6c6c5905cbe" the -P flag exposed the application on windows range of ports.

I stopped the container using "docker stop/ rm container ID"

I then portmapped the container to the host port using the -p flag "-p 9090:8080" which gave access to the application on the host.

I stopped the container using "docker rm container ID"

Using this command "docker run --name assignment-webserver -d -p 9090:8080  -e BORDER_COLOR=blue -v /c:/Users/'Olajire Aiyedun'/Videos/theworks/atVenu/devOpsAssignment/solution/data.csv:/app/data.csv f6c6c5905cbe", I was able to add the blue border to the application and able to view the result.

