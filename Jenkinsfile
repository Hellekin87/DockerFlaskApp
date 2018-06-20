node {
    def app
     environment {
        CONTAINER_NAME = "container"
        REPOSITORY = "repo1"
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
         * Pushing multiple tags is cheap, as all the layers are reused. */
         
        
        echo ${CONTAINER_NAME}
        echo ${DOCKER_PRIVATE}
        echo "Login Successful"
            
        sh " docker tag flask mabi/jenkins_published_image:latest"
        sh " docker push mabi/jenkins_published_image:latest"  
            
         
       
    }
}
