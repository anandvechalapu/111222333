namespace 111222333.API
{
    using 111222333.DTO;
    using 111222333.Service;
    using Microsoft.AspNetCore.Mvc;
    using System.Collections.Generic;

    [Route("api/[controller]")]
    [ApiController]
    public class BatchProcessController : ControllerBase
    {
        private BatchProcessService _batchProcessService;

        public BatchProcessController(BatchProcessService batchProcessService)
        {
            _batchProcessService = batchProcessService;
        }

        [HttpGet("{id}")]
        public ActionResult<BatchProcess> GetById(int id)
        {
            return _batchProcessService.GetById(id);
        }

        [HttpGet]
        public ActionResult<IEnumerable<BatchProcess>> GetAll()
        {
            return _batchProcessService.GetAll();
        }

        [HttpPost]
        public void Add(BatchProcess batchProcess)
        {
            _batchProcessService.Add(batchProcess);
        }

        [HttpPut]
        public void Update(BatchProcess batchProcess)
        {
            _batchProcessService.Update(batchProcess);
        }

        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _batchProcessService.Delete(id);
        }
    }
}