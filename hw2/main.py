from enum import Enum
import re
import argparse
from termcolor import colored

class State(Enum):
    S0 = 0
    S1 = 1
    S2 = 2
    S3 = 3
    S4 = 4
    S5 = 5
    S6 = 6
    S7 = 7
    S8 = 8
    S9 = 9
    S10 = 10
    S11 = 11
    S12 = 12
    S13 = 13
    S14 = 14
    S15 = 15
    S16 = 16
    S17 = 17
    END = 18


class Symbol(Enum):
    VOID = 'void'
    INT = 'int'
    CHAR = 'char'
    FLOAT = 'float'
    DOUBLE = 'double'
    BOOL = 'bool'
    LPAREN = '('
    RPAREN = ')'
    COMMA = ','
    LBRACE = '{'
    RBRACE = '}'
    EQUALS = '='
    CONST = 'CONST'
    SEMICOLON = ';'
    SPACEBAR = ' '
    IDENTIFIER = 'IDENTIFIER'
    OTHER = 'OTHER'


transitions = {
    State.S0: {Symbol.VOID: State.S1, Symbol.INT: State.S1, Symbol.CHAR: State.S1, Symbol.FLOAT: State.S1, Symbol.DOUBLE: State.S1, Symbol.BOOL: State.S1},
    State.S1: {Symbol.SPACEBAR: State.S2},
    State.S2: {Symbol.IDENTIFIER: State.S3, Symbol.SPACEBAR: State.S2},
    State.S3: {Symbol.SPACEBAR: State.S3, Symbol.LPAREN: State.S4},
    State.S4: {Symbol.RPAREN: State.S9, Symbol.SPACEBAR: State.S4, Symbol.VOID: State.S5, Symbol.INT: State.S5, Symbol.CHAR: State.S5, Symbol.FLOAT: State.S5, Symbol.DOUBLE: State.S5, Symbol.BOOL: State.S15},
    State.S5: {Symbol.SPACEBAR: State.S6},
    State.S6: {Symbol.IDENTIFIER: State.S7, Symbol.SPACEBAR: State.S6},
    State.S7: {Symbol.RPAREN: State.S9, Symbol.COMMA: State.S8, Symbol.SPACEBAR: State.S7},
    State.S8: {Symbol.SPACEBAR: State.S8, Symbol.VOID: State.S5, Symbol.INT: State.S5, Symbol.CHAR: State.S5, Symbol.FLOAT: State.S5, Symbol.DOUBLE: State.S5, Symbol.BOOL: State.S15},
    State.S9: {Symbol.LBRACE: State.S10, Symbol.SPACEBAR: State.S9},
    State.S10: {Symbol.RBRACE: State.END, Symbol.IDENTIFIER: State.S11, Symbol.SPACEBAR: State.S10, Symbol.VOID: State.S14, Symbol.INT: State.S14, Symbol.CHAR: State.S14, Symbol.FLOAT: State.S14, Symbol.DOUBLE: State.S14, Symbol.BOOL: State.S14},
    State.S11: {Symbol.EQUALS: State.S12, Symbol.SPACEBAR: State.S11},
    State.S12: {Symbol.IDENTIFIER: State.S13, Symbol.CONST: State.S13, Symbol.SPACEBAR: State.S12},
    State.S13: {Symbol.SEMICOLON: State.S10, Symbol.SPACEBAR: State.S13},
    State.S14: {Symbol.SPACEBAR: State.S15},
    State.S15: {Symbol.IDENTIFIER: State.S16, Symbol.SPACEBAR: State.S15},
    State.S16: {Symbol.COMMA: State.S17, Symbol.SEMICOLON: State.S10, Symbol.SPACEBAR: State.S16},
    State.S17: {Symbol.IDENTIFIER: State.S16, Symbol.SPACEBAR: State.S17},
}
initial_state = State.S0
final_states = {State.END}


def check_function_definition(string):
    current_state = initial_state
    current_word = ''
    for symbol in string:
        if symbol.isdigit() or symbol.isalpha() or symbol == '_':
            current_word += symbol
        else:
            if current_word:
                if re.match(r'void|int|char|float|double|bool', current_word):
                    symbol_enum = Symbol[current_word.upper()]
                elif re.match(r'[a-zA-Z_][a-zA-Z_0-9]*$', current_word):
                    symbol_enum = Symbol.IDENTIFIER
                elif re.match(r'[0-9]+$', current_word):
                    symbol_enum = Symbol.CONST
                else:
                    symbol_enum = Symbol.OTHER
                current_word = ''
                if current_state in transitions and symbol_enum in transitions[current_state]:
                    current_state = transitions[current_state][symbol_enum]
                else:
                    print(colored(f'Error: Expected symbol "{symbol_enum.value}"', 'red'))
                    return False

            try:
                symbol_enum = Symbol(symbol)
            except ValueError:
                print(colored(f'Error: Invalid symbol "{symbol}"', 'red'))
                return False
            
            if current_state in transitions and symbol_enum in transitions[current_state]:
                current_state = transitions[current_state][symbol_enum]
            else:
                print(colored(f'Error: Expected symbol "{symbol_enum.value}"', 'red'))
                return False

    if current_state in final_states:
        print(colored('Parsed Successfully', 'green'))
        return True
    else:
        print(colored('Error while parsing', 'red'))
        return False



def main():
    parser = argparse.ArgumentParser(description='Check function definitions')
    parser.add_argument('-f', '--file', help='File name to read function definitions from')
    args = parser.parse_args()

    if args.file:
        file_path = args.file

        with open(file_path, 'r') as file:
            for line in file:
                line = line.strip()  # Удаляем лишние пробелы и символы новой строки
                check_function_definition(line)
    else:
        input_string = input('Введите определение функции: ')
        check_function_definition(input_string)

if __name__ == '__main__':
    main()