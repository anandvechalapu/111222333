using System;
using System.Collections.Generic;
using 111222333.DTOSharingOfUPSI;
using Microsoft.AspNetCore.Mvc;

namespace 111222333.API
{
    [Route("api/[controller]")]
    public class SharingOfUPSIController : Controller
    {
        private readonly Service111222333 _service;

        public SharingOfUPSIController(Service111222333 service)
        {
            _service = service;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var models = _service.GetAll();
            return Ok(models);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var model = _service.GetById(id);
            return Ok(model);
        }

        [HttpPost]
        public IActionResult Insert([FromBody]Model model)
        {
            _service.Insert(model);
            return Ok();
        }

        [HttpPut]
        public IActionResult Update([FromBody]Model model)
        {
            _service.Update(model);
            return Ok();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _service.Delete(id);
            return Ok();
        }
    }
}