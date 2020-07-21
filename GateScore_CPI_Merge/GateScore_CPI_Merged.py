# -*- coding: utf-8 -*-
"""

@author: Aishwarya Srinivasan

MTP Allocation 

Merging CPI and Gate Score Files

"""
#%% Importing Libraries
import pandas as pd


#%% Merging CPI and Gate Score
Cpi = pd.read_excel('CPI.xlsx')
GateScore = pd.read_excel('GATE_Score.xlsx')
Gate = GateScore.dropna(axis='rows')
Student_details = pd.merge(Cpi,Gate, on = ["Applicant Name"] )

Student_details = Student_details.sort_values(by='CPI',ascending=False)
Student_details = Student_details.drop(columns='Application Seq No')
