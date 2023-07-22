#include <iostream>
#include <string>
#include <cstdlib>

int main() {
    for (std::string line; std::getline(std::cin, line);) {
        int i = 0;

        line += '\n';
        while (line[i] != '\n')
        {
            if(line[i] == ' ' || line[i] == '\t'){
                i++;
            } else {
                break;
            }
        }
        
        std::string str;
        while (line[i] != '\n')
        {
            str.push_back(line[i]);
            i++;
        }
        

        std::cout << str << std::endl;
    }
	exit(EXIT_SUCCESS);
}
