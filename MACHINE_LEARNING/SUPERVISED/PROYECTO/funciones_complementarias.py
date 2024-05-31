import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from scipy.stats import norm
from sklearn.preprocessing import StandardScaler
from scipy import stats


def drop_columns_threshold(df):
    missing_values = df.isnull().sum()
    missing_values = missing_values[missing_values > 0]
    missing_values = missing_values / df.shape[0]
    missing_values = missing_values[missing_values > 0.5]
    df = df.drop(missing_values.index, axis=1)
    return df

# función que indica los valores nulos de un dataframe y el porcentaje relativo de nulos respecto al total de valores
def missing_values_table(df):
        mis_val = df.isnull().sum()
        mis_val_percent = 100 * df.isnull().sum() / len(df)
        mis_val_table = pd.concat([mis_val, mis_val_percent], axis=1)
        mis_val_table_ren_columns = mis_val_table.rename(
        columns = {0 : 'Valores perdidos', 1 : '% del total'})
        mis_val_table_ren_columns = mis_val_table_ren_columns[
            mis_val_table_ren_columns.iloc[:,1] != 0].sort_values(
        '% del total', ascending=False).round(1)
        print ("Su selección tiene " + str(df.shape[1]) + " columnas.\n"      
            "Hay " + str(mis_val_table_ren_columns.shape[0]) +
              " columnas que tienen valores perdidos.")
        return mis_val_table_ren_columns

#Función que me liste el P-Value de todas las variables con respecto a SalePrice
def anova(df, column):
    filtered_data = df.dropna(subset=[column])
    groups = filtered_data.groupby(column)['SalePrice'].apply(list)
    F, p = stats.f_oneway(*groups)
    return p
