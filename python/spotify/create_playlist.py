#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 Julian Bustamante <jbustamante35@gmail.com>
#
# Distributed under terms of the MIT license.

"""
Tutorial from https://www.youtube.com/watch?v=7J_qcttfnJA

API used:
YouTube [https://developers.google.com/youtube/v3]
Spotify [https://developer.spotify.com/documentation/web-api/]
youtube-dl [https://github.com/ytdl-org/youtube-dl]
Python Requests [https://requests.readthedocs.io/en/master/]

Steps:
1) Log into YouTube
2) Get liked videos
3) Create new playlist
4) Search for song
5) Add song to playlist
"""

import json
import os

import requests
import youtube_dl
from exceptions import ResponseException
from secrets import spotify_token, spotify_user_id

import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors

class CreatePlaylist:

    def __init__(self):
        self.user_id        = spotify_user_id
        self.spotify_token  = spotify_token
        self.youtube_client = self.get_youtube_client()
        self.all_song_info  = {}

    def get_youtube_client(self):
        # Sample Python code for youtube.channels.list
        # See instructions for running these code samples locally:
        # https://developers.google.com/explorer-help/guides/code_samples#python

        # Disable OAuthlib's HTTPS verification when running locally.
        # *DO NOT* leave this option enabled in production.
        os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"

        api_service_name    = "youtube"
        api_version         = "v3"
        client_secrets_file = "client_secret.json"

        # Get credentials and create an API client
        scopes = ["https://www.googleapis.com/auth/youtube.readonly"]
        flow   = google_auth_oauthlib.flow.InstalledAppFlow \
                .from_client_secrets_file(client_secrets_file, scopes)
        credentials = flow.run_console()

        # From Youtube DATA API
        youtube_client = googleapiclient.discovery.build(
                api_service_name, api_version, credentials=credentials)

        return youtube_client

    # Get liked Youtube videos and add to dictionary of important song info
    def get_liked_videos(self):
        request = self.youtube_client.videos().list(
            part = "snippet,contentDetails,statistics",
            myRating = "like"
        )

        response = request.execute()

        # Collect each video and info
        for item in response["items"]:
            video_title = item["snippet"]["title"]
            youtube_url = "https://www.youtube.com/watch?v={}".format(item["id"])

            # Youtube-dl to collect song name and title
            video = youtube_dl.YoutubeDL({}).extract_info(
                    youtube_url, download=False)
            song_name = video["track"]
            artist = video["artist"]

            # Save song info
            self.all_song_info[video_title]= {
                "youtube_url": youtube_url,
                "song_name": song_name,
                "artist": artist,

                # Song uri
                "spotify_uri": self.get_spotify_url(song_name, artist)
            }


    def create_playlist(self):
        request_body = json.dumps({
                "name": "Youtube Liked Vids",
                "description": "All Liked Youtube Videos",
                "public": True
            })

        query = "https://api.spotify.com/v1/users/{}/playlists" \
            .format(self.user_id)

        response = requests.post(
                query,
                data    = request_body,
                headers = {
                    "Content-Type" : "application/json",
                    "Authorization" : "Bearer {}".format()
                    }
        )

        response_json = response.json()

        # Playlist ID
        return response_json["id"]


    def get_spotify_url(self, song_name, artist):
        query = "https://api.spotify.com/v1/search?query=track%3A{}+artist%3A{}&type=track&offset=0&limit=20".format(
            song_name,
            artist
        )

        response = requests.get(
            query,
            headers = {
            "Content-Type": "application/json",
            "Authorization": "Bearer {}".format(spotify_token)
            }
        )

        response_json = response.json()
        songs = response_json["tracks"]["items"]

        # Only get first song of playlist to start adding songs
        uri = songs[0]["uri"]

    # Dew the Thing!
    # Add new song into new Spotify playlist
    def add_song_to_playlist(self):
        # Populate dictionary

        print("I'm right here")
        self.get_liked_videos()

        # Collect all uri
        uri = []
        for song,info in self.all_song_info.items():
            uri.append(info["spotify_uri"])

        # Create playlist
        playlist_id = self.create_playlist()

        # Add songs to playlist
        request_data = json.dumps(uris)
        query        = "https://api.spotify.com/v1/playlists/{}/tracks" \
                .format(playlist_id)

        response = requests.post(
            query,
            data    = request_data,
            headers = {
                "Content-Type": "application/json",
                "Authorization": "Bearer {}".format(self.spotify_token)
            }
        )

        response_json = response.json()
        print("Did this work?")
        return response_json

if __name__ == '__main__':
    cp = CreatePlaylist()
    cp.add_song_to_playlist()

