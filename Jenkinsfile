pipeline 
{
    agent any
    
    tools{
    	maven 'maven'
        }
        
    environment{
   
        BUILD_NUMBER = "${BUILD_NUMBER}"
   
    }
    

    stages 
    {
        stage('Build') 
        {
            steps
            {
                 git 'https://github.com/jglick/simple-maven-project-with-tests.git'
                 bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            post 
            {
                success
                {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        
        
        
        stage("Deploy to QA"){
            steps{
                echo("deploy to qa done")
            }
        }
                
        stage('Run Docker Image with Regression Tests') {
    steps {
        script {
        
        def exitCode = bat(script: "docker run --name apitesting${BUILD_NUMBER} -e MAVEN_OPTS='-Dsurefire.suiteXmlFiles=src/test/resources/testrunners/testng_regression.xml' pradeeprajgowda/apitestautomation:latest", returnStatus: true)
            if (exitCode != 0) {
                currentBuild.result = 'FAILURE' // Mark the build as failed if tests fail
            }
            
            // Even if tests fail, copy the report (if present)
            bat "docker start apitesting${BUILD_NUMBER}"
       	   // bat "sleep 60"
            bat "docker cp apitesting${BUILD_NUMBER}:/app/reports/APIExecutionReport.html ${WORKSPACE}/reports"
            bat "docker rm -f apitesting${BUILD_NUMBER}"
       			 }
    		}
		}
		
		
		
		stage('Publish Regression Extent Report'){
            steps{
                     publishHTML([allowMissing: false,
                                  alwaysLinkToLastBuild: false, 
                                  keepAll: false, 
                                  reportDir: 'reports', 
                                  reportFiles: 'APIExecutionReport.html', 
                                  reportName: 'API HTML Regression Extent Report', 
                                  reportTitles: ''])
            }
        }
        
        
         

         
    }
}