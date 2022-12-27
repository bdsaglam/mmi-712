# Hidden Technical Debt in Machine Learning Systems
The paper covers ML-specific risk factors in designing real-world ML systems.  These include boundary erosion, entanglement, hidden feedback loops, undeclared consumers, data dependencies, configuration issues, changes in the external world, and a variety of system-level anti-patterns.
It uses technical debt framework popular in software engineering. The term "technical debt" is coined by Cunningham in 1992 to refer long-term maintanence costs of software due to moving quickly in software engineering. Paying technical debt includes activities that doesn't introduce new functionality but enable and ease future development. These can be improving test, writing documentation, refactoring code, and etc.
The paper claims that ML systems have technical debt incurred from both traditional software engineering and ML specific issues. It particularly focus on system-level interactions where tech-debt may accumulate fast.

Unlike traditional software engineering, it's hard to have strict abstraction boundaries for machine learning systems. Adding new features, changing hyperparameters, and other settings may cause significant changes on the system. 
When an ML model is constructed as a correction model on another existing model, it creates a dependency. If these kind of dependencies become too many in a system, improving one model in isolation may not improve or even worsen the overall system performance.
Undeclared consumers of an ML model may cause increase cost and difficulty in making any change on this model due to the potential adverse impact on the consumers. Hence, it's important to restrict access to the output of an model.

The paper claims that data dependencies might cause more problems than code dependencies, as it's more difficult to detect its issues compared to the latter. Unstable data dependencies may cause problems for their consumers when they change or even improve. One mitigation to this is to version-control such data sources so that any change to data is explicit and versioned. 
Underutilized data dependencies may make ML systems unnecessarily vulnerable to the changes. For instance, when there are two correlated features of which one is causal, the model may fail to identify causal feature and choose the other one. If the correlations change later due to world behaviour, the model may start performing worse.

Live ML system may influence their own behavior if they update over time. Hidden feedback loops can cause two ML systems to indirectly influence each other. 

When general-purpose packages are used to develop ML systems, it often cause writing glue-code to get data into right structure and format. Besides decreasing efficiency of development team, this may make it harder to experiment with other packages. One remedy is to wrap general-purpose packages into a common API so that changing packages doesn't need too much effort.
Data pipelines may be another source of issues for ML systems. As new data sources are identified, it's often tempting to implement new data pipelines to integrate new data sources into the existing system. This causes having too many pipelines. Additionally, these pipelines require expensive end-to-end testing. Instead, it's suggested to holistically design a data pipeline to handle data collection and feature extraction.
Experimental code paths not only brings additional maintanence costs but also may cause expensive bugs.
The paper argues that ML literature lacks good abstractions unlike other successful fields of software engineering, such as relational database.

ML systems has large number of configuration options such as selected features, data version, algorithm-specific learning settings, data processing steps, etc. Hence, a good configuration system must support specifying configurations easily, preventing manual errors, verification of configuration, etc.


As the changes in external world direclty impacts ML system's performance, it's necessary to implement measures to handle them. 
One effective way is monitoring ML systems. For instance, an ML system might be monitored for prediction bias. The assumption is that the distribution of training predictions must be similar to the production predictions. Hence, by monitoring the changes in this distribution, the issues such as data drifts, data preprocessing bugs can be detected. 
For the systems taking actions in real world, there can be set limits for model actions and alerts can be triggered if they are exceeded.