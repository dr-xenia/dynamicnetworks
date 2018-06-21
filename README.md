Interpreting Dynamic Connectivity by comparing methods 
--

The goal of this project is to opensource ongoing efforts to estimate and characterize various aspects of dynamic brain connectivity analysis. As a starting point, we will provide (1a) a set of functions that use scikit-learn, nilearn, bct (+numpy, scipy, nistats,...) that can be used to estimate dynamic connectivity states with a set of connectivity metrics, sliding windows and clustering algorithms, (1b) as well as decomposition methods (e.g. ICA, dictionary learning) , (2) simple methods to calculate null statistical models using bootstrapping procedures, (3) dynamic graph theory metrics, and (4) basic visualizations. We encourage interested researchers to join us in order to either help building the examples, or contribute with new methods, or test our methods on their own data.

Contributors
--

Charles Zheng

Kamil Bonna

Karolina Finc

Xenia Kobeleva

Jessica Dafflon

Sam Guay

Mansoureh Fahimi

Majd Abdallah

Nicolas Farrugia

Julian Kosciessa

To Do
--
- nilearn/plotting script to plot the HMM states
- sklearn script to perform community detection of the intersubject FO correlation matrix (from G_LouvainCommunity.ipynb) and output metastate time-series for each subject -> Fractional Occupancy, switching rate
