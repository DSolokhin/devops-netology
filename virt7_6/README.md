**Задача 1**  

1.  
resource и data_source:
ResourcesMap: map[string]*schema.Resource

https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L411

DataSourcesMap: map[string]*schema.Resource

https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L169

2.  
name конфликтует с: ConflictsWith: []string{"name_prefix"}
объявлено в Schema: map[string]*schema.Schema

https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/resource_aws_sqs_queue.go#L56

максимальная длинна имени: 80 символов
https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1038

ограничения по регулярному выражению для имени:
[0-9A-Za-z-_] в том числе доп ограничения fifo, которые определены в func validateSQSNonFifoQueueName func validateSQSFifoQueueName.

https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1041
