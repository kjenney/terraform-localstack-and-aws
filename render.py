#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import glob
import argparse
import shutil

from jinja2 import Environment
from jinja2 import FileSystemLoader

parser = argparse.ArgumentParser(description='Run Terraform for a specific provider.')
parser.add_argument('-p', '--provider', help='the provider to use', required=True)
args = parser.parse_args()

def render(template, context):
    """Render Jinja templates"""

    path, filename = os.path.split(template)
    return Environment(
        loader=FileSystemLoader(path or './')
    ).get_template(filename).render(context)


def render_from_variable(provider):
    context = {'provider':provider}
    for template in glob.glob('./*.j2'):
       rendered_filename = '{}.tf'.format(os.path.splitext(template)[0])
       with open(f"{rendered_filename}", 'w') as fh:
           fh.write(render(template, context))

if __name__ == "__main__":
    render_from_variable(args.provider)