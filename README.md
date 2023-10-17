# Inception

<h5>WHAT IS DOCKER ?</h5>

**Docker est un outil qui peut empaqueter une application et ses dépendances dans un conteneur isolé par Solomon Hykes en mars 2013.** Vous creez un super programme, Docker repond aux problematiques suivantes : 
* Une dépendance n’est pas compatible avec votre version de logiciel 😅
* Vous possédez déjà la dépendance mais dans une version différente 😑
* Votre dépendance n’existe pas sur votre OS 😓
* Votre dépendance crash au lancement 😮‍💨**

Le grand avantage de Docker est la possibilité de modéliser chaque conteneur sous la forme d'une image que l'on peut stocker localement. 

🔎 Un conteneur est une machine virtuelle sans noyau.  

📌 Ce que j’appelle noyau est tout l’ensemble du système permettant à la machine virtuelle de fonctionner, l’OS, le coté graphique, réseau, etc…  

🔎 En d’autres termes, un conteneur ne contient que l’application et les dépendances de l’application.  


<details><summary><h5>DOCKERFILE</h5></summary>

A Dockerfile is a text-based configuration file used in Docker to define the steps and instructions needed to create a Docker image. It provides a set of commands that tell Docker how to assemble an image that can be run as a container. This is an example, it is a NGINX image : 

```
FROM		alpine:3.12

RUN			apk update && apk upgrade && apk add	\
							openssl			\
							nginx			\
							curl			\
							vim				\
							sudo

RUN			rm -f /etc/nginx/nginx.conf

COPY		./config/nginx.conf /etc/nginx/nginx.conf
COPY		scripts/setup_nginx.sh /setup_nginx.sh

RUN			chmod -R +x /setup_nginx.sh

EXPOSE		443

ENTRYPOINT	["sh", "setup_nginx.sh"]
```

Some keywords...

<details><summary>`FROM` </summary> Permet d’indiquer à Docker sous quel OS doit tourner votre machine virtuelle. C’est le premier mot clef de votre Dockerfile et celui ci est obligatoire. Les plus courants sont debian:buster pour Debian ou alpine:x:xx pour Linux.</details>

<details><summary>`RUN` </summary> Permet de lancer une commande sur votre machine virtuelle   
  💡L’équivalent de se connecter en ssh, puis de taper une commande bash, comme : echo “Hello World!”, qui affichera….   
  
En général, les premiers RUN fournit dans le Dockerfile consistent à mettre à jour les ressources de votre VM, comme apk, ou encore d’ajouter les utilitaires basiques comme vim, curl ou sudo.</details>

<details><summary>`COPY` </summary> 

Vous l’avez ! Cela permet en effet de copier un fichier.     

Le copier ? À partir d’ou ? Vous indiquez simplement ou se trouve votre fichier à copier à partir du répertoire ou se trouve votre Dockerfile, puis la ou vous souhaitez le copier dans votre machine virtuelle.    

💡Une image docker c’est un dossier, il contient obligatoirement votre Dockerfile à la racine du dossier mais peut aussi contenir un tas d’autres fichiers pour ensuite pouvoir les copier directement dans votre VM. </details>

<details><summary>`EXPOSE` </summary> 

Ici, c’est une question de réseau 📡   
L'instruction EXPOSE informe Docker que le conteneur écoute sur les ports réseaux spécifiés au moment de l'exécution. EXPOSE ne rend pas les ports du conteneur accessibles à l'hôte.   

Attendez ! Quoi ? Le conteneur écoute sur le port réseau et n'est pas accessible à l'hôte ? Qu'est-ce que cela signifie ? 😣   

L'instruction EXPOSE expose le port spécifié et le rend disponible uniquement pour la communication entre conteneurs. Comprenons cela à l'aide d'un exemple. Disons que nous avons deux conteneurs, une application wordpress et un serveur mariadb. Notre application wordpress a besoin de communiquer avec le serveur mariadb pour plusieurs raisons.   

Pour que l'application WordPress puisse parler au serveur MariaDB, le conteneur WordPress doit exposer le port. Jetez un œil au Dockerfile de l'image officielle de wordpress et vous verrez une ligne disant EXPOSE3306. C'est ce qui aide les deux conteneurs à communiquer l'un avec l'autre.   

Ainsi, lorsque votre conteneur WordPress essaie de se connecter au port 3306 du conteneur MariaDB, c'est l'instruction EXPOSE qui rend cela possible.   

Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB, il est important que les deux conteneurs soient exécutés dans le même réseau docker </details>

<details><summary>`ENTRYPOINT`</summary>
Youpi ! Votre container semble prêt à démarrer.

Cependant il serait surement plus judicieux de demander au container de lancer une certaine commande au lancement de celui-ci. C’est ce que permet de faire le mot-clef ENTRYPOINT !

Il suffit d’indiquer votre commande, argument par argument, dans le format suivant :
`ENTRYPOINT “bash” , ”-c”, “"$(curl https://grademe.fr )"” ]` 
</details>

More information [here](https://www.nicelydev.com/docker/mots-cles-supplementaires-dockerfile#:~:text=Le%20mot%2Dcl%C3%A9%20EXPOSE%20permet,utiliser%20l'option%20%2Dp%20.)

</details>

<details><summary><h5>DOCKER HUB</h5></summary>

Docker Hub is a cloud-based service provided by Docker that serves as a central repository for Docker images. It's a platform where developers and teams can share, store, and manage their Docker container images. Docker met a disposition une sorte d’App Store, contenant des images (conteneur) de milliers de personnes, simplifiant encore plus son usage 👍

Imaginez que vous souhaitiez héberger un site internet, il vous faudrait par exemple installer NGINX. L’installer sur son ordinateur ? Vous n’auriez pas retenu la leçon ? Et si vous n’aviez pas le bon OS, ou les mauvaises dépendances ? Nous aurions besoin du container Docker qui installe de lui même NGINX.Ca tombe bien, étant connu, l’image NGINX à été publié par NGINX sur le Docker Hub! 🥳

Here are some key points about Docker Hub:

**Image Repository:** It's a place where you can find a wide variety of pre-built Docker images for different software and applications. These images serve as templates for creating containers.

**Official and Community Images:** Docker Hub hosts "official" images that are maintained and verified by the respective software vendors or projects. There are also "community" images created and shared by individual developers and communities.

**Version Control:** Docker Hub allows you to store different versions or tags of an image. This makes it easy to access specific versions of software.

**Collaboration and Sharing:** Developers can share their own Docker images with others, making it easy to distribute applications or configurations in a consistent container format.

**Automated Builds:** Docker Hub provides a feature called "Automated Builds" that automatically builds a Docker image whenever changes are made to the associated source code repository (e.g., on GitHub).

**Integration with Docker CLI:** Docker CLI (Command Line Interface) can pull images from Docker Hub using simple commands, making it easy to deploy applications.

**Public and Private Repositories:** Docker Hub offers both public and private repositories. Public repositories are accessible to anyone, while private repositories are restricted to specific users or teams.

**Organizations and Teams:** Docker Hub allows users to create organizations, where teams can collaborate on projects and share images within a controlled environment.

**Docker Certified:** Docker Hub includes images that have been tested, verified, and certified to work with Docker Enterprise, providing an added level of assurance for enterprise deployments.

**User Accounts and Profiles:** Users can create accounts on Docker Hub to manage their images, repositories, and settings.

**Rate Limits:** Free accounts on Docker Hub have rate limits for the number of image pulls. Subscriptions with higher limits are available for more demanding use cases.

Overall, Docker Hub is a valuable resource for the Docker community, providing a centralized place to discover, share, and manage Docker container images. It's particularly useful for quickly deploying applications in a consistent manner using Docker containers.
</details>


<details><summary><h5>DOCKER COMPOSE</h5></summary>

Docker Compose is a tool that allows you to define and manage multi-container Docker applications. It's particularly useful for setting up complex applications that require multiple containers to work together, such as a web application with a database and caching system.

Docker Compose is a command-line tool. It's used by running commands in your terminal or command prompt.

Here are some key points about Docker Compose:

**Definition with YAML:** Docker Compose uses a YAML file to define the services, networks, and volumes needed for your application. This file is typically named docker-compose.yml.

**Multi-Container Applications:** Docker Compose is designed to manage applications that consist of multiple interconnected containers. Each container represents a separate component of the application, such as a web server, a database, a caching system, etc.

**Easy Configuration:** The docker-compose.yml file allows you to specify various settings for your containers, such as environment variables, exposed ports, linked services, and more.

**Orchestration and Dependency Management:** Docker Compose handles the orchestration of containers, ensuring they start and stop in the correct order. It also manages the dependencies between them.

**Simplified Deployment:** With Docker Compose, you can define your entire application stack in a single file, making it easy to deploy on different environments, like development, staging, and production.

**Command Line Interface (CLI):** Docker Compose comes with a command-line interface that allows you to manage your multi-container Docker applications. You can start, stop, and manage your containers using commands like docker-compose up, docker-compose down, etc.

Network Isolation: By default, Docker Compose creates a separate network for your application, allowing containers to communicate with each other using their service names or aliases.

**Volumes:** Docker Compose allows you to define volumes, which are used to persist data generated by your containers.

**Scalability:** While Docker Compose is primarily used for development and testing, it can be a starting point for more advanced orchestration tools like Docker Swarm or Kubernetes when you need to scale your application to a production environment.

<details><summary>Common Docker Compose commands:</summary>

*  **docker-compose up:** This command starts up your Docker Compose-defined services. It creates and starts containers based on the configurations specified in your docker-compose.yml file.

*  **docker-compose down:** This command stops and removes the containers defined in your docker-compose.yml file.

*  **docker-compose build:** This command builds or rebuilds the Docker images defined in your docker-compose.yml file.

*  **docker-compose ps:** This command lists the running containers in your Docker Compose environment.

*  **docker-compose exec:** This command allows you to execute commands inside a running container.

*  **docker-compose logs:** This command displays the logs of your services.

*  **docker-compose run:** This command allows you to run a one-off command on a service.

*  **docker-compose restart:** This command restarts all the services in your Docker Compose environment.
</details>

These are just a few examples. Docker Compose provides a range of commands for managing your multi-container applications. Remember that you would typically run these commands in the same directory as your docker-compose.yml file.

In summary, Docker Compose simplifies the process of managing multi-container Docker applications, making it easier for developers to define, configure, and deploy complex systems. It's especially valuable for development and testing workflows.

</details>

<details><summary><h5>RANDOM STUFF</h5></summary>

*  What's YAML ?     
YAML stands for "YAML Ain't Markup Language" or sometimes "Yet Another Markup Language". It's a human-readable data serialization format. In simpler terms, it's a way to format data that can be easily read by humans and processed by computers. Here are some key characteristics of YAML:

**Readable:** YAML is designed to be easy for humans to read and write. It uses indentation and a clean syntax without the need for special characters like braces or semicolons.

**Hierarchical Structure:** It uses indentation to define data structures. This means that the level of indentation determines the parent-child relationships between elements.

**Data Types:** YAML supports various data types like strings, numbers, booleans, lists, and dictionaries (similar to arrays and objects in other programming languages).

**Comments:** You can add comments in YAML files using the # symbol. Comments are ignored by parsers and are used for human-readable explanations.

**Portability:** YAML files can be used in different programming languages and platforms. It's often used for configuration files in various applications.

**Common Use Cases:** YAML is commonly used for configuration files, data exchange between languages, and in scenarios where human-readable data is needed.

```
[EXAMPLE STRING]

name: John Doe

[EXAMPLE LIST]

fruits:
  - apple
  - banana
  - cherry

[EXAMPLE DICTIONNARY]

person:
  name: John Doe
  age: 30
  occupation: Developer

[EXAMPLE NESTED STRUCTURES]

person:
  name: John Doe
  contact:
    email: john@example.com
    phone: 555-555-5555
```
</details>
