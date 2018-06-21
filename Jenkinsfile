
node {
    def app
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        echo "Start building the image.."
        app = docker.build("${env.JOB_NAME}")
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
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD')])
                {
                    sh "docker login --username="+USERNAME+"--password="+PASSWORD+" docker.io"
                    echo "Login Successful... start pushing image to docker-hub"

                    sh " docker tag ${env.JOB_NAME} mabi/${env.JOB_NAME}_jenkins:latest"
                    sh " docker push mabi/${env.JOB_NAME}_jenkins:latest"                     
                }

    }
}

