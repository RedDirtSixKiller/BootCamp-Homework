   
import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect
#from app import db
from flask import Flask, jsonify
import datetime as dt


# Relative Date


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite", echo=True)
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
M = Base.classes.measurement
S = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return"""<html>
    <h1>List of all available routes</h1>
<ul>
    <br>
    <li>
        Precipitations from last year:
        <br>
        <a href="/api/v1.0/precipitation">/api/v1.0/precipitation</a>
    </li>
    <br>
    <li>
        Stations:
        <br>
        <a href="/api/v1.0/stations">/api/v1.0/stations</a>
    </li>
    <br>
    <li>
        Temps:
        <br>
        <a href="/api/v1.0/tobs">/api/v1.0/tobs</a>
    </li>
    <br>
    <li>
        Return a JSON list of tmin, tmax, tavg for the dates greater than or equal to the date provided:
        <br>Replace &ltstart&gt with a date in Year-Month-Day format.
        <br>
        <a href="/api/v1.0/2017-02-28">/api/v1.0/2017-02-28</a>
    </li>
    <br>
    <li>
        Return a JSON list of tmin, tmax, tavg for the dates in range of start date and end date inclusive:
        <br>
        Replace &ltstart&gt and &ltend&gt with a date in Year-Month-Day format.
        <br>
        <br>
        <a href="/api/v1.0/2017-02-28/2017-03-05">/api/v1.0/2017-02-28/2017-03-05</a>
    </li>
    <br>
</ul>
    </html>
    """


@app.route("/api/v1.0/precipitation")
def precipitation():
    # Docstring 
    """Return a list of precipitations from last year"""
    # Design a query to retrieve the last 12 months of precipitation data and plot the results
    session = Session(engine)
    max_date = session.query(M.date).order_by(M.date.desc()).first()

    # Get the first element of the tuple
    max_date = max_date[0]

    # Calculate the date 1 year ago from today
    # The days are equal 366 so that the first day of the year is included
    year_ago = dt.datetime.strptime(max_date, "%Y-%m-%d") - dt.timedelta(days=365)
    
    # Perform a query to retrieve the data and precipitation scores
    results_precipitation = session.query(M.date, M.prcp).filter(M.date >= year_ago).all()

    # Convert list of tuples into normal list
    precipitation_dict = dict(results_precipitation)

    return jsonify(precipitation_dict)

@app.route("/api/v1.0/stations")
def stations(): 
    # Docstring
    """Return a JSON list of stations from the dataset."""
    # Query stations
    session = Session(engine)
    results_stations =  session.query(M.station).group_by(M.station).all()

    # Convert list of tuples into normal list
    stations_list = list(np.ravel(results_stations))

    return jsonify(stations_list)

@app.route("/api/v1.0/tobs")
def tobs(): 
    # Docstring
    """Return a JSON list of Temperature Observations (tobs) for the previous year."""

    # Design a query to retrieve the last 12 months of precipitation data and plot the results
    session = Session(engine)
    max_date = session.query(M.date).order_by(M.date.desc()).first()

    # Get the first element of the tuple
    max_date = max_date[0]

    # Calculate the date 1 year ago from today

    year_ago = dt.datetime.strptime(max_date, "%Y-%m-%d") - dt.timedelta(days=365)
    # Query tobs
    results_tobs = session.query(M.date, M.tobs).filter(M.date >= year_ago).all()

    # Convert list of tuples into normal list
    tobs_list = list(results_tobs)

    return jsonify(tobs_list)



@app.route("/api/v1.0/<start>")
def start(start=None):

    # Docstring
    """Return a JSON list of tmin, tmax, tavg for the dates greater than or equal to the date provided"""
    session = Session(engine)

    from_start = session.query(M.date, func.min(M.tobs), func.avg(M.tobs), func.max(M.tobs)).filter(M.date >= start).group_by(M.date).all()
    from_start_list=list(from_start)
    return jsonify(from_start_list)

    

@app.route("/api/v1.0/<start>/<end>")
def start_end(start=None, end=None):
    # Docstring
    """Return a JSON list of tmin, tmax, tavg for the dates in range of start date and end date inclusive"""
    session = Session(engine)
    
    between_dates = session.query(M.date, func.min(M.tobs), func.avg(M.tobs), func.max(M.tobs)).filter(M.date >= start).filter(M.date <= end).group_by(M.date).all()
    between_dates_list=list(between_dates)
    return jsonify(between_dates_list)



if __name__ == '__main__':
    app.run(debug=True)
