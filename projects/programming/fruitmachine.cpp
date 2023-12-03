#include <iostream>

using namespace std;

int main()
{
	// This will output clubs (♣), diamonds (♦), hearts (♥), and spades (♠) if run in a Windows CLI (on Windows)
	cout << char(3) << endl;
	cout << char(4) << endl;
	cout << char(5) << endl;
	cout << char(6) << endl;

	// This will print out ASCII in the official standard range (7 bits)
	for (int i = 0; i < 128; i++)
	{
		cout << char(i) << endl;
	}

	return 0;
}

