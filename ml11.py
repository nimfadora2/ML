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
    mu = X.mean(axis = 0)
    sigma = X.var(axis = 0)
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

pval = np.zeros((Xval.shape[0], Xval.shape[1]))
pval[:,0] = stats.norm(mu, sigma).pdf(Xval[:,0])
pval[:,1] = stats.norm(mu1, sigma1).pdf(Xval[:,1])

def select_threshold(pval, yval):
    best_epsilon = 0
    best_f1 = 0
    f1 = 0

    step = (pval.max() - pval.min()) / 1000

    for epsilon in np.arange(pval.min(), pval.max(), step):
        preds = pval < epsilon

        tp = np.sum(np.logical_and(preds == 1, yval == 1)).astype(float)
        fp = np.sum(np.logical_and(preds == 1, yval == 0)).astype(float)
        fn = np.sum(np.logical_and(preds == 0, yval == 1)).astype(float)

        precision = tp / (tp + fp)
        recall = tp / (tp + fn)
        f1 = (2 * precision * recall) / (precision + recall)

        if f1 > best_f1:
            best_f1 = f1
            best_epsilon = epsilon

    return best_epsilon, best_f1

#print(yval)

print(select_threshold(pval,yval))

print(mu,sigma,mu1,sigma1)