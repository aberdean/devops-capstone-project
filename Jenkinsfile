pipeline {

    agent any
    
    stages {
    	
        stage('Lint HTML') {
	        steps {
                sh 'tidy -q -e *.html'
	        }    
	    }
	    
	    stage('Lint Dockerfile') {
	        steps {
	            sh 'hadolint Dockerfile'
	        }
	    }
	    
	    stage('Build Docker image') {
	        steps {
	            sh 'docker build -t aberdean/capstone:v2 .'
	        }
	    }
	    
	    stage('Upload Docker image to Docker Hub') {
	        steps {
	            withDockerRegistry([url: '', credentialsId: 'dockerhub']) {
	                sh '''
    	                docker push aberdean/capstone:v2
    	            '''
	            }
	        }
	    }
	    
	    stage('Deploy app') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl apply -f https://raw.githubusercontent.com/aberdean/devops-capstone-project/master/deploment.yaml'
	    		}
	    	}
	    }
	    
	    stage('Check deployment') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl get deployment capstone-deployment'
	    		}
	    	}
	    }
    }
}
