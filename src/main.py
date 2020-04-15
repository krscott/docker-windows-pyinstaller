import argparse
import os
import pyodbc
import sys


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def sources_drivers():
    sources = pyodbc.dataSources()
    dsns = list(sources.keys())
    dsns.sort()
    return {
        [dsn]: sources[dsn]
        for dsn in dsns
    }

def connect_access_file(filename):
    filename = os.path.abspath(filename)

    if not os.path.isfile(filename):
        if os.path.isdir(filename):
            raise IsADirectoryError(filename)
        raise FileNotFoundError(filename)

    drivers = {
        '.mdb': 'Microsoft Access Driver (*.mdb)',
        '.accdb': 'Microsoft Access Driver (*.mdb, *.accdb)'
    }

    fileext = os.path.splitext(filename)[1]

    if fileext not in drivers:
        raise RuntimeError(f"No driver found for '{fileext}' file")

    conn_str = f'DRIVER={{{drivers[fileext]}}};DBQ={filename};'

    eprint(conn_str)

    return pyodbc.connect(conn_str)


if __name__ == '__main__':
    def main():
        parser = argparse.ArgumentParser(description='MS Access Tester')
        parser.add_argument(
            'file', nargs='?',
            help='Access File (*.mdb, *.accdb) to test'
        )

        args = parser.parse_args()

        if args.file:
            cnxn = connect_access_file(args.file)
            crsr = cnxn.cursor()
            for table_info in crsr.tables(tableType='TABLE'):
                print(table_info.table_name)

        else:
            print(sources_drivers())
            print(pyodbc.drivers())

    main()
