# TYDES: Test Your DEtection Skills

This is a simple application that lets the user classify a set of breast cancer histological images.

## Origin of the Problem

Mitotic count is an important parameter for the prognosis of breast cancer. However, Mitosis detection in  images of H&E stained slides of breast cancer is a challenging problem and requires a very experienced user, to be proficiently accomplished. 

## Literature

This detection problem and has not been much addressed in the literature of Image Analysis and Pattern Recognition: the first contest among various detection techniques has been conducted just recently at [*ICPR2012*](http://ipal.cnrs.fr/ICPR2012/).

## The idea

There is a significant difference between the human (the histologist) and the automated system, that difference can be summed up by the term "experience".
The human operator has observed thousands of images, while the automated system has been generally trained on a subset of specific images (eg: the ones proposed in the contest http://ipal.cnrs.fr/ICPR2012/ ).
Hence the idea of the TYDES application: we let humans operate with more or less the same information available to the machine. The most interesting part of the results is not to see who is more capable, instead to understand if there exist any particular patterns that are easily recognizable by the human and not by the machine, or vice versa.

## The Application

After a phase of training, where the user can observe, for a limited amount of time, two subsets of small portion of images which are already classified in *positive* and *negative*. After that, the user has to classify another subset of random images, each of which can be a positive or a negative match. At any moment, the user can consult the repository of training images. At the end of the exercise, the user is given a code that he can use to review his results.
A specific subsection of the application shows overall statistics, collected by every execution of the test.

### Contacts

[Claudio Caccia](www.pipolauro.org)