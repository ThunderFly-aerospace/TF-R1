from setuptools import setup, find_packages
from os import path
from io import open

here = path.abspath(path.dirname(__file__))

with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(

    name='TFdashboard',
    version='2019.6.1',
    description='UAV dashboard application',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/ThunderFly-aerospace/TF-R1',

    author='ThunderFly s.r.o., Roman Dvorak',
    author_email='dvorakroman@thunderfly.cz',

    classifiers=[
        'Development Status :: 3 - Alpha',
        'Topic :: Scientific/Engineering',
        'Topic :: Scientific/Engineering :: Atmospheric Science',
        'Topic :: Scientific/Engineering :: Physics',
        'Topic :: Scientific/Engineering :: Visualization',

        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Environment :: Other Environment',

        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
    ],
    keywords='UAV Mavlink Drone dashboard ThunderFly',

    python_requires='>=3.3.*',
    install_requires=['kivy', 'dronekit', 'pyttsx3'],

    package_data={
        'media': ['media'],
    },
    #packages=find_packages(),
    packages=['src', 'src.widgets'],

    entry_points={
        'console_scripts': [
            'TFdashboard=src.dashboard:dashboard',
        ],
    },
    project_urls={
        'Bug Reports': 'https://github.com/ThunderFly-aerospace/TF-R1/issues',
    },
)
