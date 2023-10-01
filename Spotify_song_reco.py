import streamlit as st
import numpy as np
import pandas as pd
import pickle
import difflib
import spotipy
from sklearn import datasets # sklearn comes with some toy datasets to practice
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from matplotlib import pyplot
from sklearn.metrics import silhouette_score
from spotipy.oauth2 import SpotifyClientCredentials
import config

sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id= config.client_id,
                                                           client_secret= config.client_secret))
df = pd.read_csv('audio_features_df.csv')
df_b = pd.read_csv('df_b.csv')
df_b = df_b.drop(['Unnamed: 0'], axis=1)


numerical = df.select_dtypes(np.number)
X = numerical
X = X.drop(['Unnamed: 0'], axis=1)
scaler = StandardScaler()
scaler.fit(X)
X_scaled = scaler.transform(X)
X_scaled_df = pd.DataFrame(X_scaled, columns = X.columns)
#display(X.head())
print()

kmeans = KMeans(n_clusters=40, random_state=1234)
kmeans.fit(X_scaled_df)
labels = kmeans.labels_
clusters_ = labels
X["cluster"] = clusters_


from IPython.display import IFrame

track_id = "3dPQuX8Gs42Y7b454ybpMR"
IFrame(src="https://open.spotify.com/embed/track/"+track_id,
       width="320",
       height="80",
       frameborder="0",
       allowtransparency="true",
       allow="encrypted-media",
      )


def play_song(track_id):
    return IFrame(src="https://open.spotify.com/embed/track/"+track_id,
       width="320",
       height="80",
       frameborder="0",
       allowtransparency="true",
       allow="encrypted-media",
      )  


user_input = input('What are you fancy to listen now?')

if user_input in df_b['titles'].values:
            print("Here you go!")
            user_input_json = sp.search(q=user_input, limit=1)
            user_input_id = user_input_json['tracks']['items'][0]['id']
            display(play_song(user_input_id))

else:
        user_input_json=sp.search(q=user_input, limit = 1)
        user_input_id = user_input_json['tracks']['items'][0]['id']
        display(play_song(user_input_id))
        ui_af = sp.audio_features(user_input_id)
        ui_df = pd.DataFrame(ui_af[0], index=[0])
        ui_df_dropped = ui_df.drop(columns=['analysis_url','id','track_href','type','uri'], axis = 1)
        ui_scaled = scaler.transform(ui_df_dropped)
        user_cluster = kmeans.predict(ui_scaled)[0]
        X['id'] = df['id']
        rec_df = X.loc[X['cluster']==user_cluster].sample()
        user_rec_id = rec_df['id']
        user_id = list(user_rec_id)[0]
        print("Here you go!")
        display(play_song(user_id))