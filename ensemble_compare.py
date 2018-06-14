import numpy as np
import matplotlib.pyplot as plt

from sklearn import datasets

from sklearn.ensemble import BaggingClassifier, AdaBoostClassifier, GradientBoostingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import cross_val_score

RANDOM_STATE = 1

np.set_printoptions(precision=2)

#%% Load the dataset.

data = datasets.load_wine()

X = data.data
y = data.target

#%% Define classifiers and classifier ensembles.

tree = DecisionTreeClassifier(min_samples_leaf = 3, random_state = 1)
bagging = BaggingClassifier(random_state = 1, n_estimators = 50)
ada = AdaBoostClassifier(random_state = 1, algorithm='SAMME', n_estimators = 50)
grad = GradientBoostingClassifier(random_state = 1,min_samples_leaf = 3,subsample = 0.5,max_depth = 1,learning_rate=1)


#%% Compare performance of the models.

print(cross_val_score(tree,X,y,cv=5), np.cumsum(cross_val_score(tree,X,y,cv=5)))
print(cross_val_score(bagging, X,y,cv=5))
print(cross_val_score(ada, X,y,cv=5))
print(cross_val_score(grad, X,y,cv=5))

#%% Plot OOB estimates for Gradient Boosting Classifier.

# FIXME: implement
