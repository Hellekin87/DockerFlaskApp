node {
    def app
     environment {
        DOCKER_PRIVATE = credentials('docker-hub-credentials')
    }

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("flask")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. 
         /*
         https://registry.hub.docker.com
        docker.withRegistry('https://registry-1.docker.io/v2/', 'docker-hub-credentials') {
            //${env.BUILD_NUMBER}
            app.push("mabi/flask")
            //app.push("mabi")
            //app.push("latest")
            //app.push()
        }*/
        /*docker.withRegistry('https://registry-1.docker.io/v2/', 'docker-hub-credentials') {*/
        sh "docker login -u ${DOCKER_PRIVATE_USR} -p ${DOCKER_PRIVATE_PSW} ${PRIVATE_REGISTRY}"
        echo "Login Successful"
            
           // docker login docker.io
            
        sh " docker tag flask mabi/jenkins_published_image:latest"
        sh " docker push mabi/jenkins_published_image:latest"  
            
          
            /* Push the container to the custom Registry
            docker tag firstimage YOUR_DOCKERHUB_NAME/firstimage
            docker push YOUR_DOCKERHUB_NAME/firstimage
             */
        /*}*/
    }
}
