# Challenges in Deploying Machine Learning: a Survey of Case Studies

This survey reviews published reports of deploy- ing machine learning solutions in a variety of use cases, industries and applications and extracts practical considerations corresponding to stages of the machine learning deployment workflow.


In our survey we consider three main types of papers:
• Case study papers that report experience from a single ML deployment project. Such works usually go deep into discussing each challenge the authors faced and how it was overcome.
• Review papers that describe applications of ML in a particular field or industry. These re- views normally give a summary of challenges that are most commonly encountered during
the deployment of the ML solutions in the reviewed field.
• “Lessons learned” papers where authors reflect on their past experiences of deploying ML
in production.


## Machine learning deployment workflow
• Data management, which focuses on preparing data that is needed to build a machine learning model;
• Model learning, where model selection and training happens;
• Model verification, the main goal of which is to ensure the model adheres to certain func-
tional and performance requirements;
• Model deployment, which is about integration of the trained model into the software in-
frastructure that is necessary to run it. This stage also covers questions around model main- tenance and updates.

### Data management
- Data collection
Data collections involves activities to discover, understand, and organize the available. It can be difficult to organize multiple data sources in large organizations where the software is architected with many micro-services with single responsibility causing data dispersion. 

- Data preprocessing
Data preprocessing involves schema identification, imputation of missing values, simplifying data, and mapping raw data to a convenient format. 

- Data augmentation
Model performance is adversely impacted with lack of high-variance data. As it's expensive to label datasets, data augmentation is a common practice to generate more data from the labelled data available. However, if the augmented data drifts from the real data, it may cause poor performance in practice or even safety risks for autonomous vehicles.

- Data analysis
Data analysis is performed to uncover potential biases or unexpected distribution shifts. Due to the lack of data profiling tools, practitioners are unable to ensure data quality which directly impacts model performance.

### Model Learning
- Model selection
Model complexity, resource constraints and interpretability are taken into account while selecting an ML model for practical applications.
- Model training & HPO
Training large models and hyper-parameter optimizaton can be costly and harmful to the environment due to indirect CO2 emission. Privacy is also a concern when training models on user data.
- Model verification
Outlining requirements for a machine learning model is necessary before evaluating it. Rather than generic metrics such as accuracy or recall, domain-specific and business metrics has more priority when assessing model performance. 
Formal verification verifies that software functionality follows the requirements defined within the scope of the project. 
Ideally an ML model is tested in real-life setting, whic can be infeasible for some use cases. Depending on the use case, it's been demonstrated that simulation-based testing might yield drastically different results than model performance in practice. 
Data issues may creep into the pipeline and harm model performance. Hence, data validation should be performed eary in the pipeline to prevent such issues.

### Model Deployment
A trained machine learning model is to be deployed to production to provide value for business. It requires mainly two things: infrastructure to operate the model and implementing the model itself. The first lies within systems engineering but the latter must be handled by ML practitioners. 
Although machine learning model development has significant differences to traditional software development, it can borrow good ideas from the latter such as code reuse, setting boundaries of abstraction, code review, and etc.

It's crucial to monitor any software service in production. ML models trained regularly may have the risk of influencing their behaviour by their own predictions. ML models perform poorly on out-of-distribution instances; hence, it's important detect outliers in production data.

ML models should be re-trained with new data to be up-to-date as there might be shifts in the data. Concept shift may happen due to an event or gradually and may be have adverse effects on model performance. An example to concept drift due to an abrupt event is the change in financial behaviour after the financial crisis in 2008.
If an ML models is used to support human decision-making, it is important to not erode user's trust when updating the model even if it achieves better accuracy.

## Cross-cutting aspects

There are many cross-cutting aspects of ML model deployment workflow such as ethics, law, user trust, and security. 
ML models may have biases due to the biases in training data anc may worsen social inequalities. Another concern is the spread of disinformation with ML models by generating fake news and profiles on media. 
As machine learning adoption in industry and social life grows, governments legistlate new regulations for use and development of ML models. 
It's shown by various studies and cases that strong communication and engagement with the users of ML systems are crucial for earning user trust. 
As ML is getting used more in critical systems, it brings security vulnerabilities due to adverserial attacks such as data poisoning, model stealing, and model inversion.