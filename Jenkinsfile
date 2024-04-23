pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    parameters{
         string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: true,description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])

    }
    
    // environment{
    //     BUILD_SERVER_IP='ec2-user@172.31.33.147'
    //     IMAGE_NAME='devopstrainer/java-mvn-privaterepos'
    // }

    stages {
        stage('Compile') {
            // agent {label "linux_slave"}
            agent any
            steps {              
              script{
                     echo "COMPILING"
                     echo "Compiling the code in Env ${params.Env}"
                     sh "mvn compile"
                    }             
            }
        }
        stage('Test') {
            when{
                expression{
                        params.executeTests == true

                }
            }
            steps {
                 script{
                     echo "TESTING"
                     echo "Testing the code in Env ${params.Env}"
                     sh "mvn test"
                    }    
                }
            }
        stage('Package') {
            steps {
                script{
                echo "Packaging the code"
                echo "Deploying the app version ${params.APPVERSION}"
                sh "mvn package"
            }
            }
        }
        post{
            always{
                junit 'target/surefire-reports/*.xml'
            }
        }
        
    }
}