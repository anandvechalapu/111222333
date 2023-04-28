Visual Studio

using System;
using System.Collections.Generic;
using 111222333.DTO;

namespace 111222333.Service
{
    public interface IStudentService
    {
        IEnumerable<Student> GetAllStudents();
        Student GetStudentById(int id);
        void AddNewStudent(Student student);
    }
}