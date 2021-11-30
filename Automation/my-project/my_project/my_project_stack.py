from aws_cdk import core
from aws_cdk import cloudformation_include as cfn_inc

class MyStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        template = cfn_inc.CfnInclude(self, "Template",  
            template_file="01_IAM.yml")