## Deploys resources

if [ -z "$1" ]; then
	echo "Region must be set"
   	exit 1
else
        region="$1"
	export AWS_DEFAULT_REGION="$region"
fi

if [ -z "$2" ]; then
        echo "Provider must be set"
        exit 1
else
        provider="$2"
fi

# Check that LocalStack is running
nc -zv localhost 4566  &>/dev/null
if [ "$?" -eq 0 ]; then
        echo "LocalStack is running"
else
        echo "LocalStack is not running. Run `localstack start` to start it."
        exit 1
fi

python render.py -p $provider
terraform init -reconfigure
if [ "$?" -ne 0 ]; then
        echo "Init Failed"
        exit 1
fi
if [ $provider == "localstack" ]; then
        use_localstack="-var use_localstack=true"
else
        export TF_WORKSPACE="$region"
        terraform workspace select $region
        if [ "$?" -ne 0 ]; then
                terraform workspace new $region
        fi
fi
terraform plan $use_localstack
terraform apply $use_localstack --auto-approve
