#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun  7 08:49:25 2018

@author: kislowik
"""

import numpy as np  
import pandas as pd  
import matplotlib.pyplot as plt  
from scipy.io import loadmat
from scipy import stats
 
data = loadmat('data/ex8data1.mat')  
X = data['X']   
length, number = X.shape

plt.scatter(X[:,0],X[:,1])
plt.figure()
plt.hist(X)

def estimate_gaussian(X):  
    mu = 1/(len(X))*sum(X)
    sigma = (1/(len(X)))*(sum((X-mu)**2))
    return mu, sigma
    
mu, sigma = estimate_gaussian(X[:,0])
mu1, sigma1 = estimate_gaussian(X[:,1])

Xval = data['Xval']
yval = data['yval']

muv, sigmav = estimate_gaussian(Xval[:,0])
muv1, sigmav1 = estimate_gaussian(Xval[:,1])

p = np.zeros((X.shape))
p[:,0] = stats.norm(mu, sigma).pdf(X[:,0])
p[:,1] = stats.norm(mu1, sigma1).pdf(X[:,1])

pval = np.zeros((Xval.shape))
pval[:,0] = stats.norm(muv, sigmav).pdf(Xval[:,0])
pval[:,1] = stats.norm(muv1, sigmav1).pdf(Xval[:,1])

def select_threshold(pval, yval): 
    best_epsilon = 0
    best_f1 = 0

    for i in range(1000):
        cur_eps = np.amin(pval)+i*(np.amax(pval)-np.amin(pval))/1000
        
        first = pval[:,0]<cur_eps
        second = pval[:,1]<cur_eps
        both = np.logical_and(first,second)
        
        tp = np.logical_and(both,yval)
    return best_epsilon, best_f1

#print(yval)

select_threshold(pval,yval)

print(mu,sigma,mu1,sigma1)