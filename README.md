# non-local-means

Usage example of the non-local means algorithm, using scikit-image https://github.com/scikit-image/scikit-image/blob/main/skimage/restoration/non_local_means.py. Other examples on the scikit-image website: https://scikit-image.org/docs/dev/auto_examples/filters/plot_nonlocal_means.html

If you use the non-local means method, please cite:

A. Buades, B. Coll and J. -. Morel, "A non-local algorithm for image denoising," 2005 IEEE Computer Society Conference on Computer Vision and Pattern Recognition (CVPR'05), 2005, pp. 60-65 vol. 2, doi: 10.1109/CVPR.2005.38.

```bibtex
@INPROCEEDINGS{1467423,
  author={Buades, A. and Coll, B. and Morel, J.-M.},
  booktitle={2005 IEEE Computer Society Conference on Computer Vision and Pattern Recognition (CVPR'05)}, 
  title={A non-local algorithm for image denoising}, 
  year={2005},
  volume={2},
  pages={60--65},
  doi={10.1109/CVPR.2005.38}}
```

If you use the estimate_sigma from the restoration module of the scikit-image package for the noise variance estimation, please cite:  

D. L. Donoho and I. M. Johnstone. “Ideal spatial adaptation by wavelet shrinkage.” Biometrika 81.3 (1994): 425-455. DOI:10.1093/biomet/81.3.425

```bibtex
@article{10.1093/biomet/81.3.425,
    author = {Donoho, David L and Johnstone, Iain M},
    title = {Ideal spatial adaptation by wavelet shrinkage},
    journal = {Biometrika},
    volume = {81},
    number = {3},
    pages = {425--455},
    year = {1994},
    month = {09},
    issn = {0006-3444},
    doi = {10.1093/biomet/81.3.425}}
```

## Introduction

This is a Renku project - basically a git repository with some
bells and whistles. You'll find we have already created some
useful things like `data` and `notebooks` directories and
a `Dockerfile`.

## Working with the project

The simplest way to start your project is right from the Renku
platform - just click on the `Environments` tab and start a new session.
This will start an interactive environment right in your browser.

To work with the project anywhere outside the Renku platform,
click the `Settings` tab where you will find the
git repo URLs - use `git` to clone the project on whichever machine you want.

### Changing interactive environment dependencies

Initially we install a very minimal set of packages to keep the images small.
However, you can add python and conda packages in `requirements.txt` and
`environment.yml` to your heart's content. If you need more fine-grained
control over your environment, please see [the documentation](https://renku.readthedocs.io/en/latest/user/advanced_interfaces.html#dockerfile-modifications).

## Project configuration

Project options can be found in `.renku/renku.ini`. In this
project there is currently only one option, which specifies
the default type of environment to open, in this case `/lab` for
JupyterLab. You may also choose `/tree` to get to the "classic" Jupyter
interface.

## Moving forward

Once you feel at home with your project, we recommend that you replace
this README file with your own project documentation! Happy data wrangling!