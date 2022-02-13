Thirdway Task
---
---

## Summary

This document provides an overview of the development of Modules and Application.


## Architecture

In this section, i demonstrate which used structure in The Task is 
**The Modular Architecture**.

#### Overview 

Consider the image attached, that show the main layers and how they will interact with each others

## Project Architecture

Task developed based on Modular Architecture which decoupling app into isolated modules.
Module isolations can help teams to work with these modules rapidly and independently.

There are 3 main layers in Project:

### Application Layer:

This layer responsible to define the following configuration:
1. Environment (Development, Staging, etc...) 
2. Target/Product flavors: The app must has specific variables.
   - Backend Application ID
   - Backend Organisation ID
   - Target/Product name
   - Target/Product bundle/application id

### Features Layer

This layer includes business features like (Login, Registration, etc...)

#### Every feature includes:
1. UI: to describe how user will interact with feature
2. Business: to define feature business requirements


### Core Layer

This layer includes funcational modules like (Networking, Cacher, etc...) to facilitate on other  layers (Application & Features)

## MVVM - Desgin Pattern 

Each feature/Module use MVVM(Model view view-model) Design Pattern with dependency injection which seperate all The Business Logic to the view-model and that make us writing UnitTest easily.

Each Feature use MVVM as:

### Presentation Stage:
This layer comprises UI components and UI process components .

Being at this layer, the feature has to define the way the mobile app will present it in front of the end users
 this layer includes all classes of type:
- View controller
- View

### Business Stage:
As the name suggests, the layer focuses on the business front. In simple language it focuses on the way business will be presented in front of the end users.

This includes workflows, business components and requirements such as filter, sort & mapping the UI data.

This layer includes all classes of type "ViewModel".

### Data Stage:
At this third stage data related factors are kept in mind. This includes Data access components, data helpers/utilities, and service agents.

This layer responsible to provide the different data sources such as Network, KeyChain, Core data, Files

To access this layer there is module called (Data-Module),This module built on Repository pattern to Save,Get & Cache any kind of data

## General notes:
- MVVM (Mode View-View Model) is the used pattern across all application modules.
- (Core layer) is abstracted layer, it doesn't know anything about application features and business needs.
- (Core layer) can be moved from application to another.
- (Feature layer) modules can be used by Application layer or another module in same layer.
