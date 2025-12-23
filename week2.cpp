#include <iostream>
#include <fstream>
#include <algorithm>
#include <stdexcept>
#include <string>

using namespace std;

/* ---------- TEMPLATE FUNCTION ---------- */
template <typename T>
double calculateAverage(T* data, int size) {
    if (size == 0) {
        throw runtime_error("Cannot calculate average: no readings available.");
    }

    double sum = 0;
    for (int i = 0; i < size; i++) {
        sum += data[i];
    }
    return sum / size;
}

/* ---------- CLASS DEFINITION ---------- */
class WeatherStation {
private:
    string location;
    float* readings;
    int size;
    int capacity;

    void resize() {
        capacity *= 2;
        float* newArray = new float[capacity];
        for (int i = 0; i < size; i++) {
            newArray[i] = readings[i];
        }
        delete[] readings;
        readings = newArray;
    }

public:
    WeatherStation(string loc, int cap = 5)
        : location(loc), size(0), capacity(cap) {
        readings = new float[capacity];
    }

    // Copy constructor
    WeatherStation(const WeatherStation& other)
        : location(other.location), size(other.size), capacity(other.capacity) {
        readings = new float[capacity];
        for (int i = 0; i < size; i++) {
            readings[i] = other.readings[i];
        }
    }

    ~WeatherStation() {
        delete[] readings;
    }

    void addReading(float value) {
        if (size == capacity) {
            resize();
        }
        readings[size++] = value;
    }

    void printReadings() const {
        cout << "Readings: ";
        for (int i = 0; i < size; i++) {
            cout << readings[i] << " ";
        }
        cout << endl;
    }

    void sortReadings() {
        sort(readings, readings + size);
    }

    int countAbove(float threshold) const {
        return count_if(readings, readings + size,
                        [threshold](float v) { return v > threshold; });
    }

    double average() const {
        return calculateAverage(readings, size);
    }

    void saveToFile(const string& filename) const {
        ofstream file(filename);
        if (!file) {
            throw runtime_error("File could not be opened for writing.");
        }

        file << location << endl;
        file << size << endl;
        for (int i = 0; i < size; i++) {
            file << readings[i] << endl;
        }

        file.close();
    }

    static WeatherStation loadFromFile(const string& filename) {
        ifstream file(filename);
        if (!file) {
            throw runtime_error("File could not be opened for reading.");
        }

        string loc;
        int count;
        file >> ws;
        getline(file, loc);
        file >> count;

        WeatherStation wsObj(loc, count);

        for (int i = 0; i < count; i++) {
            float temp;
            file >> temp;
            wsObj.addReading(temp);
        }

        file.close();
        return wsObj;
    }

    string getLocation() const {
        return location;
    }
};

/* ---------- MAIN FUNCTION ---------- */
int main() {
    try {
        WeatherStation station("Lahti");

        station.addReading(22.5);
        station.addReading(24.0);
        station.addReading(26.3);
        station.addReading(21.8);
        station.addReading(25.7);

        station.sortReadings();

        cout << "Location: " << station.getLocation() << endl;
        station.printReadings();

        cout << "Average: " << station.average() << endl;
        cout << "Readings above 25°C: " << station.countAbove(25.0) << endl;

        string filename = "lahti_readings.txt";
        station.saveToFile(filename);
        cout << "Saved to file: " << filename << endl;

        // Load data back into a new object
        WeatherStation loadedStation =
            WeatherStation::loadFromFile(filename);

    } catch (const exception& e) {
        cerr << "Error: " << e.what() << endl;
    }

    return 0;
}
