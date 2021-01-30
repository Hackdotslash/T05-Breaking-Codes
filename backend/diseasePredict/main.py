# Import Dependencies
import sys
import os
from joblib import dump, load
from sklearn.tree import DecisionTreeClassifier

class DiseasePrediction:
    def __init__(self, model_name=None):
        self.verbose = True
        self.model_name = model_name
    def make_prediction(self, test_data=None):
        try:
            # Load Trained Model
            path = os.getcwd()+'/diseasePredict/saved_model/decision_tree.joblib'
            print(os.path.exists(path))
            print(path)
            clf = load(str(path))
        except Exception as e:
            print(e)
            print("Model not found...")

        if test_data is not None:
            result = clf.predict(test_data)
            return result
        else:
            result = clf.predict(self.test_features)
        accuracy = accuracy_score(self.test_labels, result)
        clf_report = classification_report(self.test_labels, result)
        return accuracy, clf_report


if __name__ == "__main__":

    arr = sys.argv[1].split(',')
    b = []
    for i in arr:
        b.append(i)
    dp = DiseasePrediction()
    result = dp.make_prediction(test_data=[b])
    print(result)