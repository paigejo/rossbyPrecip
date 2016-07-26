""" 
Collection of analysis and plotting utilities for Rossbypalooza 
extreme precipitation analysis.

"""


import cartopy
import cartopy.crs as ccrs
import cartopy.io.shapereader as shapereader


def add_usa_boundaries(ax, projection):
    """ Add USA states to an axis """

    ax.add_feature(cartopy.feature.COASTLINE, linewidth=1)
    shapename = 'admin_1_states_provinces_lakes_shp'
    states_shp = shapereader.natural_earth(resolution='50m',
                                           category='cultural', name=shapename)
    for state in shapereader.Reader(states_shp).geometries():
            facecolor = [0.9375, 0.9375, 0.859375]
            edgecolor = 'black'
            ax.add_geometries([state, ], projection, linestyle='solid',
                              facecolor='none', edgecolor=edgecolor, alpha=0.5)
            
    return ax

    
