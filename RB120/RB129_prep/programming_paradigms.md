# What is a programming paradigm?

This is the philosophy of how code is designed and implemented. Thus, it reflects trade-offs for how to write a program.

# Major programming paradigms

## Procedural programming

Procedural programming is a collection of data and procedures that manipulate the data.

Data is information. Procdeures are a unit of software — of information that manipulates information.

In procedural programming the data and procedures are separate. This largely explains why it's written top-down in a sequential manner.

## Object Oriented Programming

In OOP objects store data and the procedures that are the interface between the object and the user.

So objects, like data, are information that can be manipulated. But like procedures, they're also information that describe how to manipulate information.

The methods defined within objects are the interface with the object. A message includes the message selector, which is the name of the manipulation — what we want the object to do. The message selector doesn't contain the code governing the manipulation itself — the message invokes the procedure, which has the details of the manipulation. The object that is being manipulated is called the receiver.

Classes are the descriptions of objects, and establish their states and behaviors. Objects are instances of their classes. Every object is the instance of a class.

An object has attributes that store collaborator objects (data). The sum of all collaborator objects is the state of the object.

# Key principles of OOP

## Abstraction

Abstraction is hiding unnecessary information.

The key aim of abstraction is to make the program easy to use by its users.

Abstraction in Ruby is found everywhere:
- Ruby itself is an abstraction of lower-level languages
- Methods are the abstraction of the procedures that they execute
- Objects are the abstraction of their attributes and methods

The key nuance with regards to OOP is that, in contrast with other paradigms like procedural programming, code is centered around objects. As objects are at a higher level of abstraction than independent variables and procedures, they allow us to also design programs at a higher level of abstraction — thinking about objects and their interactions with other objects.

## Encapsulation

En (within) + capsula (small box)

Encapsulation is a type of abstraction wraps the data and functionality for a part of the program in a single construct ("capsule"). Each of these constructs has interfaces through which it interacts. Additionally, we can also define the level of access to the construct

Examples of encapsulation include:
- Method access control: protected, public, private
- Getter and setter methods
- 

## Inheritance

Inheritance is a system that implicitly shares code between superclasses and their subclasses. A subclass inherits the variables and methods of its superclass, thereby inheriting definitions for how the subclass' objects should behave and what attributes they should have. However, due to the principle of specificity a subclass can always override inheritance.

In Ruby there can only be one superclass per class, unlike some other languages where a class can have multiple superclasses.

Inheritance allows us to:
- More quickly create classes that have a tight relationship to an existing class
- Establish heirarchies between classes

## Modularity

## 

# Defining key concepts

- Information: a description of something
- Software: information **describing the manipulation** of information
- Software systen: an system to manipulate information described via software
  - Constasts with a hardware system, where information manipulation is described via a physical system

