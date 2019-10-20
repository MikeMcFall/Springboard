

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```


```python
df = pd.read_json('logins.json')
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>login_time</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1970-01-01 20:13:18</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1970-01-01 20:16:10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1970-01-01 20:16:37</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1970-01-01 20:16:36</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1970-01-01 20:26:21</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.iloc[1]
```




    login_time   1970-01-01 20:16:10
    Name: 1, dtype: datetime64[ns]



It looks like each login was read in to a separate row appropriately.


```python
df['counter'] = 1
df.set_index('login_time', inplace=True)
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>counter</th>
    </tr>
    <tr>
      <th>login_time</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1970-01-01 20:13:18</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1970-01-01 20:16:10</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1970-01-01 20:16:37</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1970-01-01 20:16:36</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1970-01-01 20:26:21</th>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_resample = df.resample('15T').sum()
df_resample.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>counter</th>
    </tr>
    <tr>
      <th>login_time</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1970-01-01 20:00:00</th>
      <td>2</td>
    </tr>
    <tr>
      <th>1970-01-01 20:15:00</th>
      <td>6</td>
    </tr>
    <tr>
      <th>1970-01-01 20:30:00</th>
      <td>9</td>
    </tr>
    <tr>
      <th>1970-01-01 20:45:00</th>
      <td>7</td>
    </tr>
    <tr>
      <th>1970-01-01 21:00:00</th>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_resample.plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x180d9b38fd0>




![png](Part%201%20EDA_files/Part%201%20EDA_6_1.png)



```python
df_resample.loc['1970-01-02':'1970-01-05'].plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x180d9c04128>




![png](Part%201%20EDA_files/Part%201%20EDA_7_1.png)



```python
df_resample.groupby([df_resample.index.hour, df_resample.index.minute]).mean().plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x180ddef4048>




![png](Part%201%20EDA_files/Part%201%20EDA_8_1.png)



```python

```


```python
df_resample.groupby(df_resample.index.dayofweek).mean().plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x180d9d3d668>




![png](Part%201%20EDA_files/Part%201%20EDA_10_1.png)



```python
df_resample.groupby([df_resample.index.dayofweek, df_resample.index.hour, df_resample.index.minute]).mean().plot()
plt.xticks(range(0, 671, 96), range(7))
plt.show()
```


![png](Part%201%20EDA_files/Part%201%20EDA_11_0.png)



```python

```




    <matplotlib.axes._subplots.AxesSubplot at 0x180da9bb518>




![png](Part%201%20EDA_files/Part%201%20EDA_12_1.png)

