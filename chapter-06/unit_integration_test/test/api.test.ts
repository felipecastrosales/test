import axios from "axios";

test('Should calculate the student grade average', async function () {
    // given, when, then
    // arrange, act, assert
    const idEnrollment = 1;
    await axios.post(`http://localhost:3000/enrollments/${idEnrollment}/calculate_average`, {});
    const response = await axios.get(`http://localhost:3000/enrollments/${idEnrollment}`);
    const output = response.data;
    expect(output.average).toBe(9);
});
