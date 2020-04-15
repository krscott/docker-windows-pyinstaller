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


if __name__ == '__main__':
    def main():
        parser = argparse.ArgumentParser(description='MS Access Tester')
        parser.add_argument(
            'file', nargs='?',
            help='Access File (*.mdb, *.accdb) to test'
        )

        args = parser.parse_args()

        if args.file:
            filename = os.path.abspath(args.file)

            if not os.path.isfile(filename):
                eprint(f"Could not find file {filename}")
                sys.exit(1)

            conn_str = (
                r'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};'
                + r'DBQ={};'.format(filename)
            )
            cnxn = pyodbc.connect(conn_str)
            crsr = cnxn.cursor()
            for table_info in crsr.tables(tableType='TABLE'):
                print(table_info.table_name)

        else:
            print(sources_drivers())
            print(pyodbc.drivers())

    main()
